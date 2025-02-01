# PZP
Portable Zipped PNM

This is an experimental project to create a minimal
png like header only image library that :

1) Is completely written in C and header-only
2) Supports 8bit/16bit Monochrome/RGB/RGBA files
3) Is as fast as possible in terms of image decoding speed
4) Offers *some* form of compression
5) Will hopefully be useful (to me personally) for my fast dataloader for training large neural networks 

The code here is very experimental so no guarantees until it reaches some maturity.

The only dependency apart from a C compiler is ZSTD ( https://github.com/facebook/zstd )
To get it :
```
sudo apt install libzstd-dev
```

Similar tools are [https://github.com/phoboslab/qoi](QOI) or  [https://github.com/catid/Zpng](ZPNG)


