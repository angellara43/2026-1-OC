#define _POSIX_C_SOURCE 200809L

#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#ifdef _WIN32
#include <fcntl.h>
#include <io.h>
#ifndef STDOUT_FILENO
#define STDOUT_FILENO 1
#endif
#define pipe(pipefd) _pipe((pipefd), 4096, _O_BINARY)
#define dup _dup
#define dup2 _dup2
#define close _close
#define read _read
#else
#include <unistd.h>
#endif

void pBin8b(uint8_t dato);
void pBin16b(uint16_t dato);
void pBin32b(uint32_t dato);
void pBin64b(uint64_t dato);

static void make_binary(uint64_t value, unsigned bits, char *out)
{
    unsigned i;

    for (i = 0; i < bits; ++i) {
        unsigned shift = bits - 1 - i;
        out[i] = ((value >> shift) & 1U) ? '1' : '0';
    }
    out[bits] = '\0';
}

static int begin_capture(int *saved_stdout, int pipefd[2])
{
    fflush(stdout);

    if (pipe(pipefd) == -1) {
        perror("pipe");
        return -1;
    }

    *saved_stdout = dup(STDOUT_FILENO);
    if (*saved_stdout == -1) {
        perror("dup");
        close(pipefd[0]);
        close(pipefd[1]);
        return -1;
    }

    if (dup2(pipefd[1], STDOUT_FILENO) == -1) {
        perror("dup2");
        close(*saved_stdout);
        close(pipefd[0]);
        close(pipefd[1]);
        return -1;
    }

    close(pipefd[1]);
    return 0;
}

static int end_capture(int saved_stdout, int pipefd[2], char *buffer, size_t buffer_size)
{
    size_t used = 0;

    fflush(stdout);
    if (dup2(saved_stdout, STDOUT_FILENO) == -1) {
        perror("dup2");
        close(saved_stdout);
        close(pipefd[0]);
        return -1;
    }
    close(saved_stdout);

    while (used + 1 < buffer_size) {
        int count = read(pipefd[0], buffer + used, buffer_size - used - 1);

        if (count == -1) {
            perror("read");
            close(pipefd[0]);
            return -1;
        }

        if (count == 0) {
            break;
        }

        used += (size_t)count;
    }

    buffer[used] = '\0';
    close(pipefd[0]);
    return (int)used;
}

static int capture_8(uint8_t value, char *buffer, size_t buffer_size)
{
    int saved_stdout;
    int pipefd[2];

    if (begin_capture(&saved_stdout, pipefd) == -1) {
        return -1;
    }

    pBin8b(value);
    return end_capture(saved_stdout, pipefd, buffer, buffer_size);
}

static int capture_16(uint16_t value, char *buffer, size_t buffer_size)
{
    int saved_stdout;
    int pipefd[2];

    if (begin_capture(&saved_stdout, pipefd) == -1) {
        return -1;
    }

    pBin16b(value);
    return end_capture(saved_stdout, pipefd, buffer, buffer_size);
}

static int capture_32(uint32_t value, char *buffer, size_t buffer_size)
{
    int saved_stdout;
    int pipefd[2];

    if (begin_capture(&saved_stdout, pipefd) == -1) {
        return -1;
    }

    pBin32b(value);
    return end_capture(saved_stdout, pipefd, buffer, buffer_size);
}

static int capture_64(uint64_t value, char *buffer, size_t buffer_size)
{
    int saved_stdout;
    int pipefd[2];

    if (begin_capture(&saved_stdout, pipefd) == -1) {
        return -1;
    }

    pBin64b(value);
    return end_capture(saved_stdout, pipefd, buffer, buffer_size);
}

static int report_result(const char *name, const char *value_text,
                         const char *actual, const char *expected)
{
    if (strcmp(actual, expected) == 0) {
        printf("[OK]    %s(%s) -> %s\n", name, value_text, actual);
        return 0;
    }

    printf("[FALLO] %s(%s)\n", name, value_text);
    printf("        obtenido : %s\n", actual);
    printf("        esperado : %s\n", expected);
    return 1;
}

static int test_8(uint8_t value)
{
    char actual[128];
    char expected[65];
    char value_text[16];

    make_binary(value, 8, expected);
    if (capture_8(value, actual, sizeof(actual)) == -1) {
        return 1;
    }

    snprintf(value_text, sizeof(value_text), "0x%02X", (unsigned)value);
    return report_result("pBin8b", value_text, actual, expected);
}

static int test_16(uint16_t value)
{
    char actual[128];
    char expected[65];
    char value_text[16];

    make_binary(value, 16, expected);
    if (capture_16(value, actual, sizeof(actual)) == -1) {
        return 1;
    }

    snprintf(value_text, sizeof(value_text), "0x%04X", (unsigned)value);
    return report_result("pBin16b", value_text, actual, expected);
}

static int test_32(uint32_t value)
{
    char actual[128];
    char expected[65];
    char value_text[24];

    make_binary(value, 32, expected);
    if (capture_32(value, actual, sizeof(actual)) == -1) {
        return 1;
    }

    snprintf(value_text, sizeof(value_text), "0x%08" PRIX32, value);
    return report_result("pBin32b", value_text, actual, expected);
}

static int test_64(uint64_t value)
{
    char actual[128];
    char expected[65];
    char value_text[32];

    make_binary(value, 64, expected);
    if (capture_64(value, actual, sizeof(actual)) == -1) {
        return 1;
    }

    snprintf(value_text, sizeof(value_text), "0x%016" PRIX64, value);
    return report_result("pBin64b", value_text, actual, expected);
}

int main(void)
{
    int failures = 0;

    failures += test_8(0x00U);
    failures += test_8(0x01U);
    failures += test_8(0xA5U);
    failures += test_8(0xFFU);

    failures += test_16(0x0000U);
    failures += test_16(0x0001U);
    failures += test_16(0x1234U);
    failures += test_16(0xFFFFU);

    failures += test_32(UINT32_C(0x00000000));
    failures += test_32(UINT32_C(0x80000000));
    failures += test_32(UINT32_C(0xDEADBEEF));
    failures += test_32(UINT32_C(0xFFFFFFFF));

    failures += test_64(UINT64_C(0x0000000000000000));
    failures += test_64(UINT64_C(0x0000000000000001));
    failures += test_64(UINT64_C(0x0123456789ABCDEF));
    failures += test_64(UINT64_C(0xFFFFFFFFFFFFFFFF));

    if (failures == 0) {
        puts("\nTodas las pruebas pasaron.");
        return 0;
    }

    printf("\nPruebas con error: %d\n", failures);
    return 1;
}