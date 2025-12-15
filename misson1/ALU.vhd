library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;  -- 使用NUMERIC_STD库进行有符号运算

entity ALU is
    port (
        A, B : in STD_LOGIC_VECTOR(31 downto 0);   -- 32位操作数
        ALUctr : in STD_LOGIC_VECTOR(2 downto 0);  -- 3位ALU控制信号
        Result : out STD_LOGIC_VECTOR(31 downto 0); -- 32位运算结果
        Overflow : out STD_LOGIC;                   -- 溢出标志
        Z : out STD_LOGIC                          -- Zero-零标志
    );
end ALU;

architecture Behavioral of ALU is
    signal temp_result : STD_LOGIC_VECTOR(31 downto 0);
    signal temp_add, temp_sub : STD_LOGIC_VECTOR(32 downto 0);
    signal overflow_add, overflow_sub : STD_LOGIC;
    signal a_signed, b_signed : SIGNED(31 downto 0);
begin
    -- 类型转换
    a_signed <= SIGNED(A);
    b_signed <= SIGNED(B);
    
    -- 运算过程
    process(A, B, ALUctr, a_signed, b_signed)
    begin
        case ALUctr is
            when "000" => -- ADD: 加法
                temp_result <= A + B;
            when "001" => -- SUB: 减法
                temp_result <= A - B;
            when "010" => -- AND: 与运算
                temp_result <= A and B;
            when "011" => -- OR: 或运算
                temp_result <= A or B;
            when "100" => -- XOR: 异或运算
                temp_result <= A xor B;
            when "101" => -- NOR: 或非运算
                temp_result <= A nor B;
            when "110" => -- SLT: 有符号比较 (A < B ? 1 : 0)
                if a_signed < b_signed then
                    temp_result <= X"00000001";
                else
                    temp_result <= X"00000000";
                end if;
            when "111" => -- SLL: 逻辑左移 (B移位位数)
                temp_result <= STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(A), to_integer(UNSIGNED(B(4 downto 0)))));
            when others =>
                temp_result <= (others => '0');
        end case;
    end process;
    
    -- 溢出检测 (仅对有符号加减法)
    temp_add <= ('0' & A) + ('0' & B);
    temp_sub <= ('0' & A) - ('0' & B);
    
    overflow_add <= '1' when (A(31) = B(31)) and (temp_add(31) /= A(31)) and ALUctr = "000" else '0';
    overflow_sub <= '1' when (A(31) /= B(31)) and (temp_sub(31) /= A(31)) and ALUctr = "001" else '0';
    
    Overflow <= overflow_add or overflow_sub;
    
    -- 输出结果和零标志
    Result <= temp_result;
    Z <= '1' when temp_result = X"00000000" else '0';
    
end Behavioral;