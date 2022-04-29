PERL_SDK_DIR=src
C_SDK_DIR=c-server-sdk
C_SDK_VER:=2.6.0

.PONY: perl-server-sdk
perl-server-sdk: $(C_SDK_DIR)/include $(PERL_SDK_DIR)/Makefile
	make -C $(PERL_SDK_DIR)

$(PERL_SDK_DIR)/Makefile:
	cd $(PERL_SDK_DIR) && perl Makefile.PL

$(C_SDK_DIR)/include: c-server-sdk

.PONY: c-server-sdk
c-server-sdk:
	#if [ ! -d "$(C_SDK_DIR)/include" ]; then git clone https://github.com/launchdarkly/c-server-sdk.git $(C_SDK_DIR); fi
	wget -P $(C_SDK_DIR) https://github.com/launchdarkly/c-server-sdk/releases/download/$(C_SDK_VER)/linux-gcc-64bit-dynamic.zip
	unzip -d $(C_SDK_DIR) $(C_SDK_DIR)/linux-gcc-64bit-dynamic.zip

.PONY: clean
clean:
	make -C $(PERL_SDK_DIR) clean
