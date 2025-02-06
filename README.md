# PZP
Portable Zipped PNM


### Overview

This is an experimental project to create a minimal
PNG like header only image library that :

1) Is completely written in C and header-only
2) Supports 8bit/16bit Monochrome/RGB/RGBA files
3) Is as fast as possible in terms of image decoding speed
4) Offers *some* form of compression (this repo compresses slightly better than PNG)
5) Will hopefully be useful (to me personally) for my fast dataloader for training large neural networks 


### Dependencies

The only dependency apart from a C compiler is ZSTD ( https://github.com/facebook/zstd )

To get it :
```
sudo apt install libzstd-dev
```

### Compiling

To compile PZP use :
```
make
```

To test it :
```
make test
```

To debug it :
```
make debug
```

Similar tools are [https://github.com/phoboslab/qoi](QOI) or  [https://github.com/catid/Zpng](ZPNG)


