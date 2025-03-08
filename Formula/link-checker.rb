class LinkChecker < Formula
    homepage 'https://github.com/koba-e964/link-checker'
    version '0.0.1'

    if OS.mac?
        if Hardware::CPU.arm?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.1/link-checker_v0.0.1_darwin_arm64.zip'
            sha256 '7587944a32bdd43f8e678ad1d44f00a3089d22a6cc9d6caa69a8b5eeeb3e0f03'
        elsif Hardware::CPU.intel?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.1/link-checker_v0.0.1_darwin_amd64.zip'
            sha256 '32e0df02f66ccbdbe2d7032b8b316a6420e7bf5521fe2eb576ebb25caa13164c'
        end
    elsif OS.linux?
        if Hardware::CPU.arm?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.1/link-checker_v0.0.1_linux_arm64.tar.gz'
            sha256 'ccf55975f579d1d6974383cc799074452a5754179326929bc3b3672bf543683d'
        elsif Hardware::CPU.intel?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.1/link-checker_v0.0.1_linux_amd64.tar.gz'
            sha256 'bca7bd40e1e6b97baeb016c61a46692359aaf3f6014f7c4bb54b9d3b6b802da5'
        end
    end

    head do
        url 'https://github.com/koba-e964/link-checker'
        depends_on 'go' => :build
    end

    def install
        if build.head?
            system 'go', 'build', '-o', 'link-checker'
        else
        end
        bin.install 'link-checker'
    end
end
