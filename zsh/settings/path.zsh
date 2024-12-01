## TODO - Need to add a way to manage path between mac and linux

# Add local gopath bin to path
export GOPATH="${HOME}/go"
export PATH=$GOPATH/bin:$PATH

# Add docker to path
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

# Add .NET Core SDK tools
export PATH="$PATH:/Users/sherman/.dotnet/tools"

# Add Postgres to path
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

