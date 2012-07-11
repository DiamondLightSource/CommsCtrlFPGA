library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fofb_cc_tx_buffer is
    port (
        rd_en                   : in  std_logic;
        wr_en                   : in  std_logic;
        full                    : out std_logic;
        empty                   : out std_logic;
        wr_clk                  : in  std_logic;
        rst                     : in  std_logic;
        rd_clk                  : in  std_logic;
        dout                    : out std_logic_vector(15 downto 0);
        din                     : in  std_logic_vector(127 downto 0);
        -- Control interface
        reset                   : in  std_logic;
        timeframe_valid_i       : in  std_logic;
        max_data_count          : out std_logic_vector(7 downto 0)
   );
end fofb_cc_tx_buffer;

architecture rtl of fofb_cc_tx_buffer is

component fofb_cc_tx_fifo
port (
    rst                 : in std_logic;
    wr_clk              : in std_logic;
    rd_clk              : in std_logic;
    din                 : in std_logic_vector(127 DOWNTO 0);
    wr_en               : in std_logic;
    rd_en               : in std_logic;
    dout                : out std_logic_vector(15 DOWNTO 0);
    full                : out std_logic;
    empty               : out std_logic;
    wr_data_count       : out std_logic_vector(6 DOWNTO 0)
);
end component;

signal wr_data_count            : std_logic_vector(6 downto 0);
signal max_wr_data              : unsigned(6 downto 0) := (others => '0');

begin

fofb_cc_tx_fifo_inst : fofb_cc_tx_fifo
    port map (
        rd_en                   => rd_en,
        wr_en                   => wr_en,
        full                    => full,
        empty                   => empty,
        wr_clk                  => wr_clk,
        rst                     => rst,
        rd_clk                  => rd_clk,
        dout                    => dout,
        din                     => din,
        wr_data_count           => wr_data_count
    );

max_data_count <= std_logic_vector(resize(max_wr_data,8));

process(wr_clk)
begin
    if rising_edge(wr_clk) then
        if (reset = '1') then
            max_wr_data <= (others => '0');
        elsif (timeframe_valid_i = '1') then
            if (unsigned(wr_data_count) > max_wr_data) then
                max_wr_data <= unsigned(wr_data_count);
            end if;
        end if;
    end if;
end process;

end rtl;
