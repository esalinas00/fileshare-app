class FileSharerCLI < Thor
  
  desc "login USERNAME PASSWORD", "Athenticate to FileSharer using username and password"
  def login(username, password)
    credentials = LoginCredentials.call({username: username, password: password})
    if !credentials.failure?
      auth_account = FindAuthenticatedAccount.call(credentials)
      if auth_account
        session = {}
        session[:auth_token] = auth_account['auth_token']
        session[:current_account] = SecureMessage.encrypt(auth_account['account'])
        CLIHelper.safe_session(session)
        puts "******** Welcome to fileSharer #{username} ***********"
      else
        puts 'Your username or password did not match our records'
      end
    else
      puts 'Please enter both your username and password'
    end
  end

  desc "logout", "Logout user from fileSharer cli"
  def logout
    CLIHelper.clear_session
  end
end
