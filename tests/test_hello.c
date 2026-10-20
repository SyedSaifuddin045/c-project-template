#include "unity.h"
#include "hello.h"

void setUp(void) {}
void tearDown(void) {}

void test_say_hello_runs(void)
{
    /* Just ensure function links and runs */
    say_hello();
    TEST_PASS();
}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_say_hello_runs);
    return UNITY_END();
}
