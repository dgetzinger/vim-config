#######################################################################
#
# Makefile
#
# Copies specified vim configuration files from development directory
# to vim root directory.
#
# vim root defaults to $HOME; execute 'make INSTALL_DIR=/blah' for
# different destination.
#
#######################################################################


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Variables
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# rc files and directories in git repository omit . prefix for ease of editing.
# Dot prefixed when copied to INSTALL_DIR
src_rcfiles		:= vimrc
src_rcdir		:= vim

# User-settable variables
INSTALL_DIR		?= $(HOME)
RC_PREFIX		?= .

# Destination directories
tgt_rcdir		:= $(addprefix $(INSTALL_DIR)/,$(addprefix $(RC_PREFIX),$(src_rcdir)))
tgt_alldirs		:= $(INSTALL_DIR) $(tgt_rcdir)

# Target files. Adds '.' before file names.
tgt_rcfiles		:= $(addprefix $(INSTALL_DIR)/$(RC_PREFIX),$(src_rcfiles))
tgt_allfiles	:= $(tgt_rcfiles)

# Order matters here
tgt_all			:= $(tgt_alldirs) $(tgt_rcfiles) 

# Commands
BIN				:= /bin
GNU_BIN			:= /usr/local/bin
CP				:= /bin/cp
GREP			:= /usr/bin/egrep
MKDIR			:= /bin/mkdir -p
MV				:= /bin/mv
RM				:= /bin/rm -f

# Which OS are we running?
# TODO: cygwin
ifneq (,$(shell uname | grep -i "darwin"))
# Mac: need to install GNU gcp (part of coreutils) for backup capability,
# as OSX's native cp does not include a --backup option
# brew install coreutils
OS				:= OSX
CP				:= $(GNU_BIN)/gcp
else
OS				:= Linux
endif

# Flags evaluated recursively as suffix may change between invocations
# Suffix generates iso-like timestamp suffix, e.g., -20151102083215
#   -u option forces UTC timestamp
# If you change the suffix, conform the grep expression under "clean" target
backup_suffix 	= -$(shell date -u +%Y%m%d%H%M%S)
backup_flags	= --backup=simple --suffix=$(backup_suffix)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Default target
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: install clobber nobackup skipbackup

# install (default) normally will copy and rename existing files
# before clobber overwrites the originals
install: $(tgt_all)

# skip the backup--existing files will be *overwritten*
clobber nobackup skipbackup: backup_flags = 
clobber nobackup skipbackup: install


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Other targets
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: test_backup clean help

test_backup:
#TODO: add code that tests whether native cp has backup option and if not, \
warns user that no backups will be made and confirms that he wishes to \
continue

# Delete backup files
clean:
	$(QUIET)for file in $(addprefix $(INSTALL_DIR)/,$(shell ls -a ${INSTALL_DIR} | $(GREP) "\-\d{14}$$")); \
	do \
		if [ -f "$${file}" ]; then $(RM) "$${file}"; fi \
	done

#TODO: add 'help' target that prints out usage instructions


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Explicit rules.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$(tgt_rcfiles): $(INSTALL_DIR)/$(RC_PREFIX)%: $(CURDIR)/%
	$(QUIET)$(CP) $(backup_flags) $* $@ 


# Create any target directories that do not already exist
$(tgt_alldirs):
	$(QUIET)if [ ! -d "$@" ]; then $(MKDIR) "$@"; fi


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Debugging
# make -n for dry run; make -d for debugging output
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Unset QUIET on command line to echo commands, e.g. QUIET= make -n
QUIET			?= @

# Print values of specified variables. This is a target so make exits
# after printing.
print-%:
	$(QUIET)echo $* = $($*)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# More rules
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: eyes love whoopee money
eyes:			; $(QUIET)echo "Got a date tonight yet, sailor?"
love whoopee:	; $(QUIET)echo "Not until we're married, Buster."
money:			; $(QUIET)echo "Whaddya got to sell?"

