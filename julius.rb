require 'formula'

class Julius < Formula
  homepage 'http://julius.sourceforge.jp/'
  url 'http://sourceforge.jp/frs/redir.php?f=/julius/59049/julius-4.2.3.tar.gz'
  version '4.2.3'
  sha1 '8b1acae4079cbc5ee32b0536da5d4403361a0676'

  depends_on 'portaudio' => 'universal'

  def patches
    DATA
  end

  def install
    ENV.j1
    ENV['CFLAGS'] = '-O3 -arch i386'
    ENV['LDFLAGS'] = '-arch i386'
    args = %W[
      --enable-words-int
      --with-mictype=portaudio
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    Finish installing Julius!
    But you should prepare dictation-kit to using julius.

    If you start simple, try:

        $ wget "http://sourceforge.jp/frs/redir.php?m=keihanna&f=%2Fjulius%2F59050%2Fdictation-kit-v4.2.3.tar.gz" -O dictation-kit-v4.2.3.tar.gz
        $ tar xzf dictation-kit-v4.2.3.tar.gz
        $ cd dictation-kit-v4.2.3
        $ julius -C fast.jconf -charconv EUC-JP UTF-8

    EOS
  end
end


__END__
diff --git a/julius/main.c b/julius/main.c
index b6208f4..ad919c6 100644
--- a/julius/main.c
+++ b/julius/main.c
@@ -194,7 +194,7 @@ main(int argc, char *argv[])

   /* initialize and standby the specified audio input source */
   /* for microphone or other threaded input, ad-in thread starts here */
-  if (j_adin_init(recog) == FALSE) return;
+  if (j_adin_init(recog) == FALSE) return 0;

   /* output system information to log */
   j_recog_info(recog);
