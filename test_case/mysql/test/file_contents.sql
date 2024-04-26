
--
-- Testing files that were built to be packaged, both for existence and for contents
--

--
-- Bug #42969: Create MANIFEST files
--
-- Use a Perl script to verify that files "docs/INFO_BIN" and "docs/INFO_SRC" do exist
-- and have the expected contents.

--perl
print "\nChecking 'INFO_SRC' and 'INFO_BIN'\n";
  -- RPM package
  $dir_docs = $dir_bin;
    -- SuSE: "packages/" in the documentation path
    -- Skip the management-server directory in the documentation path for cluster release
    @dir_docs = grep { (! /management/) } glob "$dir_docs/packages/mysql-*-server*";
    $dir_docs = $dir_docs[0];
  } else {
    -- RedHat: version number in directory name
    $dir_docs = glob "$dir_docs/MySQL-server*";
    if (! -d "$dir_docs") {
      -- If not it might be ULN so try that
      -- Skip the management-server directory in the documentation path for cluster release
      @dir_docs = grep { (! /management/) } glob "$dir_bin/share/doc/mysql-*-server*";
      $dir_docs = $dir_docs[0];
      if (! -f "$dir_docs/INFO_BIN") {
        -- Debian/ Ubuntu
        $dir_docs = glob "$dir_bin/share/mysql-*/docs";
      }
    }
  }
} elsif ($dir_bin =~ m|/usr$|) {
  -- RPM build during development
  $dir_docs = "$dir_bin/share/doc";
    -- SuSE: "packages/" in the documentation path
    -- Skip the management-server directory in the documentation path for cluster release
    @dir_docs = grep { (! /management/) } glob "$dir_docs/packages/mysql-*-server*";
    $dir_docs = $dir_docs[0];
  } else {
    -- RedHat: version number in directory name
    $dir_docs = glob "$dir_docs/MySQL-server*";
    if (! -d "$dir_docs") {
      -- If not it might be ULN so try that
      @dir_docs = grep { (! /management/) } glob "$dir_bin/share/doc/mysql-*-server*";
      $dir_docs = $dir_docs[0];
      if (! -f "$dir_docs/INFO_BIN") {
        -- Debian/ Ubuntu
        $dir_docs = glob "$dir_bin/share/mysql-*/docs";
      }
    }
  }
} else {
  -- tar.gz package, Windows, or developer work (in git)
  $dir_docs = $dir_bin;
    $dir_docs = "$dir_docs/docs";
  } else {
    $dir_docs = "$dir_docs/Docs";
  }
}
$found_version = "No line 'MySQL source --.#.#'";
  if ($line =~ m|^MySQL source \d\.\d\.\d+|) {$found_version = "Found MySQL version number";
  if ($line =~ m|^commit: \w{40}$|) {$found_revision = "Found GIT revision id";
  -- "generator" on Windows, "flags" on Unix:
  if (($line =~ m| Compiler / generator used: |) ||
      ($line =~ m| Compiler flags used:|))   {$found_compiler = "Found 'Compiler ... used' line";
  if  ($line =~ m| Feature flags used:|)     {$found_features = "Found 'Feature flags' line";
