# 预备工作3 熟悉语法分析器辅助构造工具

## 表达式计算
- 相关代码位于./ExprCalc中，样例输入见./ExprCalc/example.txt
- 表达式以 \';\' 结束

## 中缀表达式转后缀表达式
- 相关代码位于./InfixToPostfix中，样例输入见./InfixToPostfix/example.txt
- 表达式以 \';\' 结束

## 变量与赋值运算
- 相关代码位于./AssignImplement中，样例输入见./AssignImplement/example.txt
- 表达式以 \';\' 结束
- 使用 \':\' + expr + \';\' 的方式输出对应表达式的值，如：
    > a = 10 + 5; \
    > :a; \
    
    > 15

## Makefile说明：
- 编译并运行
> make test
- 运行程序，并以example.txt中的内容作为输入
> make example