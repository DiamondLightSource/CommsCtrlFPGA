library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fofb_cc_puls_exp is
    port (
        mgtclk_i            : in  std_logic;
        mgtreset_i          : in  std_logic;
        short_pulse_i       : in  std_logic;
        long_pulse_o        : out std_logic
   );
end fofb_cc_puls_exp;

architecture rtl of fofb_cc_puls_exp is

constant PULS_WIDTH     : integer := 31;

signal cnt              : unsigned(4 downto 0);
signal short_pulse_prev : std_logic;

begin

process (mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then
        if (mgtreset_i = '1') then
            cnt <= (others => '0');
            long_pulse_o <= '0';
            short_pulse_prev <= '0';
        else
            short_pulse_prev <= short_pulse_i;

            if (short_pulse_i = '1' and short_pulse_prev = '0') then
                cnt <= to_unsigned(PULS_WIDTH,5);
                long_pulse_o <= '1';
            else
                if cnt = "000" then
                    long_pulse_o <= '0';
                else
                    cnt <= cnt - 1;
                end if;
            end if;
        end if;
    end if;
end process;

end rtl;

