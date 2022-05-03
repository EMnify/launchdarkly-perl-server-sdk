PERL_SDK_DIR=lib/launchdarkly
C_SDK_DIR=c-server-sdk
C_SDK_VER:=2.6.0
DESTDIR:=

.PONY: perl-server-sdk
perl-server-sdk: $(C_SDK_DIR)/include $(PERL_SDK_DIR)/Makefile
	make -C $(PERL_SDK_DIR)

$(PERL_SDK_DIR)/Makefile:
	cd $(PERL_SDK_DIR) && perl Makefile.PL

$(C_SDK_DIR)/include: c-server-sdk

.PONY: c-server-sdk
c-server-sdk:
	wget -P $(C_SDK_DIR) https://github.com/launchdarkly/c-server-sdk/releases/download/$(C_SDK_VER)/linux-gcc-64bit-dynamic.zip
	unzip -d $(C_SDK_DIR) $(C_SDK_DIR)/linux-gcc-64bit-dynamic.zip

.PONY: install
install:
	make -C $(PERL_SDK_DIR) install
	mkdir -p $(DESTDIR)/usr/share/liblaunchdarkly/ && cp $(C_SDK_DIR)/lib/libldserverapi.so $(DESTDIR)/usr/share/liblaunchdarkly/

.PONY: clean
clean:
	make -C $(PERL_SDK_DIR) clean

.PONY: deb
deb:
	dpkg-buildpackage --no-sign
	mkdir -p pkg
	mv ../liblaunchdarkly-perl_${C_SDK_VER}* pkg/
	mv ../liblaunchdarkly-perl-dbgsym_${C_SDK_VER}* pkg/
