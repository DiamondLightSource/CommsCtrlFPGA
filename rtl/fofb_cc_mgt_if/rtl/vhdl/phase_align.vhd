library ieee;
use ieee.std_logic_1164.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

entity PHASE_ALIGN is
    port (
        ENA_COMMA_ALIGN : in std_logic;
        RX_REC_CLK      : in std_logic;
        ENA_CALIGN_REC  : out std_logic
    );
end PHASE_ALIGN;

architecture RTL of PHASE_ALIGN is

-----------------------------------------------
--  Component declaration
-----------------------------------------------
component FD
-- synthesis translate_off
generic (
    INIT : bit := '1'
);
-- synthesis translate_on
port (
    Q : out STD_ULOGIC;
    C : in STD_ULOGIC;
    D : in STD_ULOGIC
);
end component;

-----------------------------------------------
--  Signal declaration
-----------------------------------------------
signal ENA_CALIGN_REC_Buffer    : std_logic;
signal phase_align_flops_r      : std_logic_vector(0 to 1);

begin

ENA_CALIGN_REC <= ENA_CALIGN_REC_Buffer;

-- To phase align the signal, we sample it using a flop clocked with the recovered
-- clock.  We then sample the output of the first flop and pass it to the output.
-- This ensures that the signal is not metastable, and prevents transitions from
-- occuring except at the clock edge.  The comma alignment circuit cannot tolerate
-- transitions except at the recovered clock edge.

phase_align_flops_0 : FD
   port map(
            D   => ENA_COMMA_ALIGN,
            C   => RX_REC_CLK,
            Q   => phase_align_flops_r(0)
           );

phase_align_flops_1 : FD
   port map(
            D   => phase_align_flops_r(0),
            C   => RX_REC_CLK,
            Q   => phase_align_flops_r(1)
           );

ENA_CALIGN_REC_Buffer <= phase_align_flops_r(1);

end RTL;
