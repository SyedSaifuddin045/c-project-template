#include "unity.h"
#include "tinyjson.h"

void setUp(void)
{
}

void tearDown(void)
{
}

void test_tinyjson_version_returns_expected_string(void)
{
    TEST_ASSERT_EQUAL_STRING("0.1.0", tinyjson_version());
}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_tinyjson_version_returns_expected_string);
    return UNITY_END();
}
