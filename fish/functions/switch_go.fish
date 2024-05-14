
function switch_go
    # Check if goversion is provided
    if test (count $argv) -eq 0
        echo "Usage: switch_go <goversion>"
    end
    set goversion $argv[1]

    if test -z $goversion
        return 1
    end

    echo "Begin to install $goversion"
    # Install the specified Go goversion
    go install golang.org/dl/go$goversion@latest
    if test $status -ne 0
        echo "Failed to install Go $goversion"
        return $status
    end

    # Download the specified Go goversion
    go$goversion download
    if test $status -ne 0
        echo "Failed to download Go $goversion"
        return $status
    end

    echo "Go $goversion installed and downloaded successfully."
    ln -sf $HOME/go/bin/go$goversion $HOME/go/bin/go
    return 0
end
