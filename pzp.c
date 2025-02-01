#include <stdio.h>
#include <stdlib.h>

#include "pzp.h"
//sudo apt install libzstd-dev


int main(int argc, char *argv[])
{
    if (argc != 4)
    {
        fprintf(stderr, "Usage: %s <compress|decompress> <input_file> <output_prefix>\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char * operation                    = argv[1];
    const char * input_commandline_parameter  = argv[2];
    const char * output_commandline_parameter = argv[3];

    if (strcmp(operation, "compress") == 0)
    {
        fprintf(stderr, "Compress %s \n", input_commandline_parameter);

        unsigned char *image = NULL;
        unsigned int width = 0, height = 0, bytesPerPixel = 0, channels = 0;
        unsigned long timestamp = 0;

        image = ReadPNM(0, input_commandline_parameter, &width, &height, &timestamp, &bytesPerPixel, &channels);
        unsigned int bitsperpixel = bytesPerPixel * 8;

        fprintf(stderr, "Width %u / Height %u \n", width, height);
        fprintf(stderr, "bitsperpixel %u / channels %u \n", bitsperpixel, channels);

        unsigned char **buffers = malloc(channels * sizeof(unsigned char *));
        for (unsigned int ch = 0; ch < channels; ch++)
        {
            buffers[ch] = malloc(width * height * sizeof(unsigned char));
        }

        split_channels_and_filter(image, buffers, channels, width, height);
        compress_combined(buffers, width,height, bitsperpixel, channels, output_commandline_parameter);

        free(image);
        for (unsigned int ch = 0; ch < channels; ch++)
        {
            free(buffers[ch]);
        }
        free(buffers);
    }
    else if (strcmp(operation, "decompress") == 0)
    {
        fprintf(stderr, "Decompress %s \n", input_commandline_parameter);

        unsigned char **buffers = NULL;
        unsigned int size = 0, width = 0, height = 0, bitsperpixel = 24, channels = 3;

        decompress_combined(input_commandline_parameter, &buffers, &size, &width, &height, &bitsperpixel, &channels);

        restore_channels(buffers, channels, width, height);

        unsigned char *reconstructed = malloc( width * height * (bitsperpixel/8)* channels );
        for (size_t i = 0; i < width * height * (bitsperpixel/8); i++)
        {
            for (unsigned int ch = 0; ch < channels; ch++)
            {
                reconstructed[i * channels + ch] = buffers[ch][i];
            }
        }

        WritePNM(output_commandline_parameter, reconstructed, width, height, bitsperpixel, channels);

        for (unsigned int ch = 0; ch < channels; ch++)
        {
            free(buffers[ch]);
        }
        free(buffers);
        free(reconstructed);
    }
    else
    {
        fprintf(stderr, "Invalid mode: %s. Use 'compress' or 'decompress'.\n", operation);
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
