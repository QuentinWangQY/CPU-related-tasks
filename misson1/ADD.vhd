library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX1X2 is
    port (
        X1 : in STD_LOGIC;
        X0 : in STD_LOGIC;
        S  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end MUX1X2;

architecture Behavioral of MUX1X2 is
begin
    Y <= X1 when S = '1' else X0;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX32X2 is
    port (
        X1 : in STD_LOGIC_VECTOR(31 downto 0);
        X0 : in STD_LOGIC_VECTOR(31 downto 0);
        S  : in STD_LOGIC;
        Y  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end MUX32X2;

architecture Behavioral of MUX32X2 is
begin
    Y <= X1 when S = '1' else X0;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX32X4 is
    port (
        X3 : in STD_LOGIC_VECTOR(31 downto 0);
        X2 : in STD_LOGIC_VECTOR(31 downto 0);
        X1 : in STD_LOGIC_VECTOR(31 downto 0);
        X0 : in STD_LOGIC_VECTOR(31 downto 0);
        S  : in STD_LOGIC_VECTOR(1 downto 0);
        Y  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end MUX32X4;

architecture Behavioral of MUX32X4 is
begin
    with S select
        Y <= X0 when "00",
             X1 when "01",
             X2 when "10",
             X3 when "11",
             (others => '0') when others;
end Behavioral;