# This software is Copyright (c) 2014 by Chris Weyl <cweyl@alumni.drew.edu>.
#
# This is free software, licensed under:
#
# The GNU Lesser General Public License, Version 2.1, February 1999

FROM rsrchboy/perl-stable:latest
MAINTAINER Chris Weyl <chris.weyl@wps.io>

# for some reason, Capture::Tiny fails to build under -q...?!
RUN cpanm -q --installdeps Capture::Tiny || { cat ~/.cpanm/build.log ; false ; }
RUN cpanm Capture::Tiny || cpanm --notest Capture::Tiny || { cat ~/.cpanm/build.log ; false ; }

# now, make sure everything is up to date
RUN cpanm -q App::cpanoutdated      || { cat ~/.cpanm/build.log ; false ; }
RUN cpan-outdated  | xargs cpanm -q || { cat ~/.cpanm/build.log ; false ; }

# And finally...
RUN cpanm -q Module::Install   || { cat ~/.cpanm/build.log ; false ; }
RUN cpanm -q Moose             || { cat ~/.cpanm/build.log ; false ; }
RUN cpanm -q Catalyst::Runtime || { cat ~/.cpanm/build.log ; false ; }
RUN cpanm -q Catalyst::Devel   || { cat ~/.cpanm/build.log ; false ; }
RUN cpanm -q Task::Catalyst    || { cat ~/.cpanm/build.log ; false ; }
