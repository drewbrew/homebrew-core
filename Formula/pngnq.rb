class Pngnq < Formula
  desc "Tool for optimizing PNG images"
  homepage "http://pngnq.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/pngnq/pngnq/1.1/pngnq-1.1.tar.gz"
  sha256 "c147fe0a94b32d323ef60be9fdcc9b683d1a82cd7513786229ef294310b5b6e2"
  revision 1

  bottle do
    cellar :any
    sha256 "dd6970fb9055fb1a6702c820e75a3d7b826e165e61c23c17b0845cca780c3da9" => :el_capitan
    sha256 "cba40b130f3d16666580be2b572721d0d8d312f60f62e4fdef656ffa825bc65e" => :yosemite
    sha256 "567b59896332ae5974077a2402eefcf3246942d82599318d95ab6e53faa6a2d7" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "libpng"

  # Fixes compilation on OSX Lion
  # png.h on Lion does not, in fact, include zlib.h
  # See: http://sourceforge.net/tracker/?func=detail&aid=3353513&group_id=213072&atid=1024252
  # See: http://sourceforge.net/tracker/?func=detail&aid=3402960&group_id=213072&atid=1024252
  patch :DATA

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end


__END__
diff --git a/src/rwpng.c b/src/rwpng.c
index aaa21fc..5324afe 100644
--- a/src/rwpng.c
+++ b/src/rwpng.c
@@ -31,6 +31,7 @@

 #include <stdio.h>
 #include <stdlib.h>
+#include <zlib.h>

 #include "png.h"        /* libpng header; includes zlib.h */
 #include "rwpng.h"      /* typedefs, common macros, public prototypes */
