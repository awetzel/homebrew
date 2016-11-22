require 'formula'

class Ethereum < Formula
  version '1.5.2-nodifficulty'

  homepage 'https://github.com/ethereum/go-ethereum'
  url 'https://github.com/ethereum/go-ethereum.git', :branch => 'release/1.5'
  patch :DATA

  devel do
    version '1.5.3'
    url 'https://github.com/ethereum/go-ethereum.git', :branch => 'master'
  end

  depends_on 'go' => :build

  def install
    ENV["GOROOT"] = "#{HOMEBREW_PREFIX}/opt/go/libexec"
    system "go", "env" # Debug env
    system "make", "all"
    bin.install 'build/bin/evm'
    bin.install 'build/bin/geth'
    bin.install 'build/bin/rlpdump'
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/geth", "--version"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ThrottleInterval</key>
        <integer>300</integer>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_bin}/geth</string>
            <string>-datadir=#{prefix}/.ethereum</string>
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
    EOS
  end
end

__END__
diff --git a/core/block_validator.go b/core/block_validator.go
index 3353683..bf9770d 100644
--- a/core/block_validator.go
+++ b/core/block_validator.go
@@ -263,11 +263,7 @@ func ValidateHeader(config *params.ChainConfig, pow pow.PoW, header *types.Heade
 // the difficulty that a new block should have when created at time
 // given the parent block's time and difficulty.
 func CalcDifficulty(config *params.ChainConfig, time, parentTime uint64, parentNumber, parentDiff *big.Int) *big.Int {
-	if config.IsHomestead(new(big.Int).Add(parentNumber, common.Big1)) {
-		return calcDifficultyHomestead(time, parentTime, parentNumber, parentDiff)
-	} else {
-		return calcDifficultyFrontier(time, parentTime, parentNumber, parentDiff)
-	}
+  return big.NewInt(0x0)
 }
 
 func calcDifficultyHomestead(time, parentTime uint64, parentNumber, parentDiff *big.Int) *big.Int {
