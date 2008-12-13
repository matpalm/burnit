#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int encode(int n) {
    return n ^ (n>>1);
}

int decode(int g) {
    int n = g;
    int s = 1;
    while(1) {
        int d = n>>s;
        n ^= d;
        if (d<=1) return n;
        s <<= 1;
    }
}

int main(int argc, char **argv)
{
    // arg check
    if (argc!=2) {
        printf("usage: cat files.16 | perl -nple's/\\s+.*//;' | ./brute_force2 16\n");
        exit(1);
    }

    // parse number lines
    const int N = atoi(argv[1]);

    // read in data from stdin
    int* sizes = malloc(N * sizeof(int));
    int n, next;
    for(n=0; n<N; n++) {
        scanf("%d",&next);
        sizes[n] = next;
    }

    // check every combo
    const int MAX = (int)(4.3 * 1024 * 1024 * 0.99);
    int best_sum = 0;
    int best_combo = 0;
    int sum = 0;
    int last_g = 0;
    const int num_combos = (int)(pow(2,N));
    for (n=1; n<num_combos; n++) {
        int g = encode(n);
        int diff = last_g ^ g;
        int idx = (int)(float)(log(diff) / log(2)); // weird castness; without (float) rounding error!
        int add = (g & diff) !=0;
        sum += (add ? 1 : -1) * sizes[idx];
        //printf("n=%d, g=%d diff=%d idx=%d add=%d sum=%d best_sum=%d\n",n,g,diff,idx,add,sum,best_sum);
        last_g = g;

        if (sum < MAX && sum > best_sum) {
            best_sum = sum;
            best_combo = g;
        }
    }

    // print answer
    printf("best_sum=%d\n",best_sum);
    printf("combo is ");
    int i;
    while (best_combo!=0) {
        if ((best_combo & 1)==1)
            printf("%d ",i);
        best_combo >>=1;
        i++;
    }
    printf("\n");

    // done
    free(sizes);
}
