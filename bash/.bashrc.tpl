# Kiro shell integration (must be before any early return)
[[ "$TERM_PROGRAM" == "kiro" ]] && export PS1='$ ' && unset PROMPT_COMMAND && . "$(kiro --locate-shell-integration-path bash)"

# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

source ~/.local/share/omarchy/default/bash/rc

alias extract="decompress"
alias tf="terraform"

export PATH="$HOME/bin:${PATH}"
export PATH="$HOME/Apps/Kiro/bin:${PATH}"
export PATH="$HOME/Apps/basis_universal/bin:${PATH}"
export PATH="$HOME/Apps/RubyMine-2025.2.1/bin:${PATH}"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export SHOPIFY_CLI_NO_ANALYTICS=1
export SHOPIFY_FLAG_STORE="60cdf7-c3"
export ANDROID_HOME=~/Android/Sdk
export SSH_AUTH_SOCK=~/.1password/agent.sock

# Wordpress / WhoShuffledThis
export DB_ROOT_PASSWORD="op://tmoi2qf2jmo7franvmgzdjcl24/WhoShuffledThis DB Password/root db password"
export DB_PASSWORD="op://tmoi2qf2jmo7franvmgzdjcl24/WhoShuffledThis DB Password/db password"

# Create a new worktree and branch from within current git directory.
ga() {
  if [[ -z "$1" ]]; then
    echo "Usage: ga [branch name]"
    return 1
  fi

  local branch="$1"
  local base="$(basename "$PWD")"
  local path="../${base}--${branch}"

  git worktree add -b "$branch" "$path"
  mise trust "$path"

  # Copy .env's over to be able to run servers
  cp app/.env "${path}/app/"
  cp ops-app/.env "${path}/ops-app/"

  # Copy the node modules over to avoid the need for `npm install`
  cp -r app/node_modules "${path}/app/"
  cp -r ops-app/node_modules "${path}/app/"

  # Copy over dev infrastructure variables for possible deployment
  cp infrastructure/dev01/terraform.tfvars "${path}/infrastructure/dev01/" 
  cp infrastructure/dev02/terraform.tfvars "${path}/infrastructure/dev02/" 

  cd "$path"
  cd app; npm install
  cd ../ops-app; npm install
  cd ..
}

# Remove worktree and branch from within active worktree directory.
gd() {
  if gum confirm "Remove worktree and branch?"; then
    local cwd base branch root

    cwd="$(pwd)"
    worktree="$(basename "$cwd")"

    # split on first `--`
    root="${worktree%%--*}"
    branch="${worktree#*--}"

    # Protect against accidentially nuking a non-worktree directory
    if [[ "$root" != "$worktree" ]]; then
      cd "../$root"
      git worktree remove "$worktree" --force
      git branch -D "$branch"
    fi
  fi
}

function posh_nosh {
  export AWS_PROFILE="posh_nosh"
}

function devzilla {
  export AWS_PROFILE="devzilla"
}

function sharedzilla {
  export AWS_PROFILE="sharedzilla"
}

function uatzilla {
  export AWS_PROFILE="uatzilla"
}

function prodzilla {
  export AWS_PROFILE="prodzilla"
}

function superzilla {
  if gum confirm "SUPERZILLA: Are you sure you want to proceed?" --default=false; then
    echo "Proceeding..."
    export AWS_PROFILE="superzilla"
  else
    echo "Good choice. Defaulting to devzilla."
    devzilla
  fi	
}

function sync-kiro-trust() {
    # Extract trusted commands from IDE settings
    TRUSTED=$(jq -c '.["kiroAgent.trustedCommands"]' ~/.config/Kiro/User/settings.json)

    # Inject them into the CLI settings
    jq ".terminal.trustedCommands = $TRUSTED" ~/.kiro/settings/cli.json > ~/.kiro/settings/cli.json.tmp && mv ~/.kiro/settings/cli.json.tmp ~/.kiro/settings/cli.json
}

devzilla

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export STRIPE_TEST_SECRET_KEY="op://tmoi2qf2jmo7franvmgzdjcl24/Stripe Stowzilla/dev02 sandbox secret key"

export NOTIFICATION_COMMAND="notify-send"
export SCREENSHOT_CUSTOMER_EMAIL="andy+dev02@stowzilla.com"
export SCREENSHOT_DEV02_CUSTOMER_EMAIL="andy+dev02@stowzilla.com"
export SCREENSHOT_DEV04_CUSTOMER_EMAIL="andy+dev04@stowzilla.com"
export SCREENSHOT_DEV06_CUSTOMER_EMAIL="andy+dev06@stowzilla.com"
export SCREENSHOT_OPS_EMAIL="andy@stowzilla.com"
export SCREENSHOT_CUSTOMER_PASSWORD=""
export SCREENSHOT_OPS_PASSWORD="${SCREENSHOT_CUSTOMER_PASSWORD}"

. "$HOME/.local/share/../bin/env"

fz() {
  local dir=(~/Code/*fizzy-"$1"-*/)
  [[ -d ${dir[0]} ]] && cd "${dir[0]}" || echo "No worktree found for $1"
}

fzk() {
  fz $1
  if [[ -n "$2" ]]; then
    export KIRO_AUTOSTART=$2
  fi
  kiro .
  exit
}

fza() {
  fz $1
  # Detect project structure and find the android build root
  if [[ -d android-app ]]; then
    cd android-app
    local pkg="com.stowzilla.customer.dev02"
  elif [[ -f gradlew ]]; then
    local pkg="com.stowzilla.ops.dev02"
  else
    echo "No Android project found"
    return 1
  fi

  ./setup-config.sh dev02
  ./gradlew assembleDebug installDebug

  if [[ -n "$2" ]]; then
    studio . &
  fi

  local log_choice
  log_choice=$(gum choose --header "Launch app ($pkg). Show logs?" "No logs" "App logs only" "All errors")

  case "$log_choice" in
    "App logs only")
      local pid
      pid=$(adb shell pidof "$pkg" 2>/dev/null)
      if [[ -n "$pid" ]]; then
        adb logcat --pid="$pid"
      else
        echo "⚠️  $pkg not running — falling back to all errors"
        adb logcat '*:E'
      fi
      ;;
    "All errors")
      adb logcat '*:E'
      ;;
  esac
}

# This one is only to be run from within the infrastructure/[env] dir
alias tfreset='sed -i "/provider \"terraform.local\/stowzilla\/dispatcher\"/,/^}/d" .terraform.lock.hcl && terraform init'

# Terraform upgrade + deploy for a given environment
# Usage: tfdeploy dev02
tfdeploy() {
  local env="${1:?Usage: tfdeploy <env>}"
  local tf_dir="infrastructure/${env}"

  if [[ ! -d "$tf_dir" ]]; then
    echo "Error: $tf_dir does not exist" >&2
    return 1
  fi

  echo "→ Refreshing dispatcher provider in $tf_dir"
  sed -i '/provider "terraform.local\/stowzilla\/dispatcher"/,/^}/d' "${tf_dir}/.terraform.lock.hcl"
  (cd "$tf_dir" && terraform init)

  echo "→ Running deploy.sh $env"
  ./scripts/deploy.sh "$env"
}


# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<
