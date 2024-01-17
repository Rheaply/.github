/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc

eval "$(/opt/homebrew/bin/brew shellenv)"

(echo '
if [ -f machine_config.env ]
then
    while IFS= read -r line; do
        eval "export $line"
    done < machine_config.env
fi') >> ~/.zshrc

if [ -z "$GH_TOKEN" ]; then
  echo "Please enter your GitHub token, you can generate one here: https://github.com/settings/tokens"
  read GH_TOKEN
  
  echo "Please enter your GitHub username"
  read GH_USERNAME

  echo "GH_TOKEN=\"$GH_TOKEN\"" >> ~/machine_config.env
  echo 'export GITHUB_TOKEN=$GH_TOKEN' >> ~/machine_config.env

  echo "export GH_USERNAME=\"$GH_USERNAME\"" >> ~/machine_config.env
  echo 'export GITHUB_USERNAME=$GH_USERNAME' >> ~/machine_config.env
fi

brew install git
brew install gh

source ~/.zshrc

mkdir ~/repos/
cd ~/repos/

gh repo clone rheaply/developer-tools

pwsh -F ./developer-tools/machine_setup/new_machine.ps1
