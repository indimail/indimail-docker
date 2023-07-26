<?php
/*-
 * Class to automatically login on a Roundcube installation
 * @compatibility RoundCube 1.0.2+
 */

/* a roundcube exception class */
class RoundCubeException extends Exception {}

/* main class */
class RoundcubeAutoLogin
{
	/* roundcube link (with a trailing slash) */
	private $_rc_link = '';
	private $ch;

	/**
	 * Creates a new RC object
	 * @param $roundcube_link the roundcube link with a trailing slash
	 */
	public function __construct($roundcube_link)
	{
		$this->_rc_link = $roundcube_link;
		$this->ch = curl_init();
	}

	/**
	 * Tries to log a RC user in using cURL. Does two requests. One to
	 * get a session token to perform the login, and one to do the actual
	 * login of the user
	 *
	 * @param $email the full e-mailaddress of the user
	 * @param $password the password of the user
	 *
	 * @returns The cookies you should set with setcookie
	 */
	public function login($email, $password)
	{
		try
		{
			$token = $this->_get_token();
		
  			if($token === FALSE) {
  				throw new RoundCubeException('Unable to get token, is your RC link correct?');
  			}

			/* make the request to roundcube */
			$post_params = array(
				'_token' => $token,
				'_task' => 'login',
				'_action' => 'login',
				'_timezone' => '',
				'_url' => '_task=login',
				'_user' => $email,
				'_pass' => $password
			);

			curl_setopt($this->ch, CURLOPT_URL, $this->_rc_link . '?_task=login');
			curl_setopt($this->ch, CURLOPT_COOKIEFILE, '');
			curl_setopt($this->ch, CURLOPT_COOKIEJAR, '');
			curl_setopt($this->ch, CURLOPT_POST, TRUE);
			curl_setopt($this->ch, CURLOPT_HEADER, TRUE);
			curl_setopt($this->ch, CURLOPT_RETURNTRANSFER, TRUE);
			curl_setopt($this->ch, CURLOPT_POSTFIELDS, http_build_query($post_params));
			$response = curl_exec($this->ch);
			$response_info = curl_getinfo($this->ch);

			if($response_info['http_code'] == 302)
			{
				/*-
				 * find all relevant cookies to set (php session + rc auth cookie)
				 * newer RoundCubes use set-cookie, older use Set-Cookie
				 */
				preg_match_all('/Set-Cookie: (.*)\b/i', $response, $cookies);

				$cookie_return = array();

				foreach($cookies[1] as $cookie)
				{
					preg_match('|([A-z0-9\_]*)=([A-z0-9\_\-]*);|', $cookie, $cookie_match);
					if($cookie_match) {
						$cookie_return[$cookie_match[1]] = $cookie_match[2];
					}
				}

				return $cookie_return;
			} else {
				throw new RoundCubeException('Login failed, please check your credentials.');
			}
		}
		catch(RoundCubeException $e)
		{
			echo 'RC error: ' . $e->getMessage();
		}
		catch(Exception $e)
		{
			echo 'General error: ' . $e->getMessage();
		}
	}
	/**
	 * Redirect to RC
	 */
	public function redirect()
	{
		header('Location: ' . $this->_rc_link . '?task=mail');
	}

	/**
	* Gets a token to use for the login
	*/
	private function _get_token()
	{
		curl_setopt($this->ch, CURLOPT_URL, $this->_rc_link);
		curl_setopt($this->ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($this->ch, CURLOPT_COOKIEFILE, '');
		curl_setopt($this->ch, CURLOPT_COOKIEJAR, '');
		$response = curl_exec($this->ch);

		preg_match('|<input type="hidden" name="_token" value="([A-z0-9]*)">|', $response, $matches);

		if($matches)
			return $matches[1];
		else
			return FALSE;
	}
}

$url=$argv[1];
$user=$argv[2];
$pass=$argv[3];

$rc = new RoundcubeAutoLogin($url);
$cookies = $rc->login($user, $pass);
if( is_array($cookies) ) {
	/* echo("login successful\n"); */
	exit(0);
} else {
	/* error message from `$rc->login` doesn't include newline */
	echo("\n");
	exit(1);
}

?>
