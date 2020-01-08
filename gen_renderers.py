#!/usr/bin/env python3
import ctypes
for i in range(0,480):
	b = bin(ctypes.c_uint.from_buffer(ctypes.c_float(-2. + i * 0.008333333333333333)).value).zfill(32)[2:]
	b = "0" * (32 - len(b)) + b
	print(str(hex(i))[2:] + ":" + b + ";")
 

