#include <stdio.h>

extern int strlen(char *str);
extern void str_mid(char *str_out, char *str1_in, int start, int end);
extern int clrBit(int value, int nbit);

static void test_strlen(char *text, int expected)
{
    int result = strlen(text);
    printf("strlen(\"%s\") = %d -> %s\n",
           text,
           result,
           result == expected ? "OK" : "ERROR");
}

static void test_str_mid(char *text, int start, int end, char *expected)
{
    char out[100];
    int i;
    int ok = 1;

    str_mid(out, text, start, end);

    for (i = 0; out[i] != 0 || expected[i] != 0; i++) {
        if (out[i] != expected[i]) {
            ok = 0;
            break;
        }
    }

    printf("str_mid(\"%s\", %d, %d) = \"%s\" -> %s\n",
           text,
           start,
           end,
           out,
           ok ? "OK" : "ERROR");
}

static void test_clrBit(int value, int nbit, int expected)
{
    int result = clrBit(value, nbit);
    printf("clrBit(%d, %d) = %d -> %s\n",
           value,
           nbit,
           result,
           result == expected ? "OK" : "ERROR");
}

int main(void)
{
    printf("Pruebas de P12.asm\n\n");

    test_strlen("", 0);
    test_strlen("Hola", 4);
    test_strlen("Organizacion", 12);

    test_str_mid("Computadoras", 0, 4, "Compu");
    test_str_mid("Computadoras", 3, 7, "putad");
    test_str_mid("Computadoras", 5, 20, "tadoras");
    test_str_mid("Computadoras", 8, 3, "");

    test_clrBit(15, 0, 14);       /* 1111 -> 1110 */
    test_clrBit(15, 2, 11);       /* 1111 -> 1011 */
    test_clrBit(128, 7, 0);       /* 10000000 -> 0 */
    test_clrBit(170, 1, 168);     /* 10101010 -> 10101000 */

    return 0;
}