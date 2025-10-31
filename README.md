#Timer 8-bit feature list shown as below:
- Configure register via APB protocol (IP is APB slave).
- Support APB transfer with no wait states and no error handling. Timer can count up and down.
- Detect overflow (count reach 255) and underflow (count reach 0).
- Support polling and interrupt (can be enable or disable).
- 2 clocks domain: One for register configuration (pclk), Other for clock divisor (ker_clk)
