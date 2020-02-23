#
# (C) Copyright 2000-2002
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#
# Copyright (c) 2017 Microsemi Corporation.
# Padmarao Begari, Microsemi Corporation <padmarao.begari@microsemi.com>
#
# Copyright (C) 2017 Andes Technology Corporation
# Rick Chen, Andes Technology Corporation <rick@andestech.com>
#
# SPDX-License-Identifier:	GPL-2.0+

ifeq ($(CROSS_COMPILE),)
ifdef CONFIG_32BIT
CROSS_COMPILE := riscv32-unknown-linux-gnu-
endif
ifdef CONFIG_64BIT
CROSS_COMPILE := riscv64-unknown-elf-
endif
endif

32bit-emul		:= elf32lriscv
64bit-emul		:= elf64lriscv

ifdef CONFIG_32BIT
PLATFORM_LDFLAGS	+= -m $(32bit-emul)
endif

ifdef CONFIG_64BIT
PLATFORM_LDFLAGS	+= -m $(64bit-emul)
endif

CONFIG_STANDALONE_LOAD_ADDR = 0x80200000 \
			      -T $(srctree)/examples/standalone/riscv.lds

PLATFORM_CPPFLAGS	+= -ffixed-gp -fpic
PLATFORM_RELFLAGS += -fno-strict-aliasing -fno-common -gdwarf-2
LDFLAGS_u-boot += --gc-sections -static -pie
