class Rfactor < Formula
    homepage 'https://github.com/koba-e964/rust-number-theory'
    version '0.1.1'

    if OS.mac?
        if Hardware::CPU.arm?
            url 'https://github.com/koba-e964/rust-number-theory/releases/download/0.1.1/rfactor_0.1.1_darwin_aarch64.zip'
            sha256 'b2c01d1df8703d58a9dcae2ba4289a8297acb1b34f354ad358cd4420617e512f'
        elsif Hardware::CPU.intel?
            url 'https://github.com/koba-e964/rust-number-theory/releases/download/0.1.1/rfactor_0.1.1_darwin_x86-64.zip'
            sha256 'b1fdbf6e12f53a0b0013aa141292f9c70849d69a171b2d99300324f0b030a14f'
        end
    elsif OS.linux?
        if Hardware::CPU.arm?
            url 'https://github.com/koba-e964/rust-number-theory/releases/download/0.1.1/rfactor_0.1.1_linux_aarch64.zip'
            sha256 'fe928cc933d3e145cb8a01dbfebbe2969ff927441f47222774325ab578132da2'
        elsif Hardware::CPU.intel?
            url 'https://github.com/koba-e964/rust-number-theory/releases/download/0.1.1/rfactor_0.1.1_linux_x86-64.zip'
            sha256 '6ca6beb44c05699920788e6ed4a1ea544c3c78d838bed6110c3dbdbc5e91cb9a'
        end
    end

    head do
        url 'https://github.com/koba-e964/rust-number-theory'
        depends_on 'rust' => :build
    end

    def install
        if build.head?
            system 'cargo' 'build' '--release' '--bin' 'rfactor'
            system 'cp' "target/release/rfactor", "rfactor"
        else
        end
        bin.install 'rfactor'
    end

    test do
        system "rfactor" "12345"
    end
end
