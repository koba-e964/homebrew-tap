class LinkChecker < Formula
    homepage 'https://github.com/koba-e964/link-checker'
    version '0.0.2'

    if OS.mac?
        if Hardware::CPU.arm?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.2/link-checker_v0.0.2_darwin_arm64.zip'
            sha256 '5e5ae4af25445e8dce0d60cf4f733650abf9e02c543b2f6979cb3ab656e070f0'
        elsif Hardware::CPU.intel?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.2/link-checker_v0.0.2_darwin_amd64.zip'
            sha256 '684c79e94af2d1566bae277b761382edf113c06f3afbdd09a851f3c938d0a44b'
        end
    elsif OS.linux?
        if Hardware::CPU.arm?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.2/link-checker_v0.0.2_linux_arm64.tar.gz'
            sha256 'd9c1e3553fac1bbc09e20d7a385a4b7bcf0e9f4d335510c41fa2c9787df4ead8'
        elsif Hardware::CPU.intel?
            url 'https://github.com/koba-e964/link-checker/releases/download/v0.0.2/link-checker_v0.0.2_linux_amd64.tar.gz'
            sha256 '2d098c8aac568b1ae475680fe0d0600d05435aaa8823cd3e8d61848016313881'
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
