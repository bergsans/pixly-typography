{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_pixlytypo (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/bergsans/Documents/dev/pixly-typography/haskell/.stack-work/install/x86_64-linux-tinfo6/f073b428714d6c807b17eba6c97eb0eb1957d6e2460e0eef99c50060741727e7/8.10.4/bin"
libdir     = "/home/bergsans/Documents/dev/pixly-typography/haskell/.stack-work/install/x86_64-linux-tinfo6/f073b428714d6c807b17eba6c97eb0eb1957d6e2460e0eef99c50060741727e7/8.10.4/lib/x86_64-linux-ghc-8.10.4/pixlytypo-0.1.0.0-LnviC6SelwwfGS0X4Mexh"
dynlibdir  = "/home/bergsans/Documents/dev/pixly-typography/haskell/.stack-work/install/x86_64-linux-tinfo6/f073b428714d6c807b17eba6c97eb0eb1957d6e2460e0eef99c50060741727e7/8.10.4/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/bergsans/Documents/dev/pixly-typography/haskell/.stack-work/install/x86_64-linux-tinfo6/f073b428714d6c807b17eba6c97eb0eb1957d6e2460e0eef99c50060741727e7/8.10.4/share/x86_64-linux-ghc-8.10.4/pixlytypo-0.1.0.0"
libexecdir = "/home/bergsans/Documents/dev/pixly-typography/haskell/.stack-work/install/x86_64-linux-tinfo6/f073b428714d6c807b17eba6c97eb0eb1957d6e2460e0eef99c50060741727e7/8.10.4/libexec/x86_64-linux-ghc-8.10.4/pixlytypo-0.1.0.0"
sysconfdir = "/home/bergsans/Documents/dev/pixly-typography/haskell/.stack-work/install/x86_64-linux-tinfo6/f073b428714d6c807b17eba6c97eb0eb1957d6e2460e0eef99c50060741727e7/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "pixlytypo_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "pixlytypo_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "pixlytypo_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "pixlytypo_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "pixlytypo_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "pixlytypo_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
