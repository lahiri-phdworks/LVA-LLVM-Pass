## LVA-LLVM-Pass

- [Live Variable Analysis](https://isoft.acm.org/winterschool17/presentation-decks/WSSE17-Day1-2-Uday-talks/live-vars.pdf)
- [LLVM Introduction](https://www.cs.cornell.edu/~asampson/blog/llvm.html)

## Updates :

- [ ] Add New LLVM Passses for Complier Optimizations.
- [ ] Add a Pass for Super Optimizations.
- [ ] Migrate to New Pass Manager. [LLVM New Pass Manager](https://github.com/alexjung/Writing-an-LLVM-Pass-using-the-new-PassManager)

## Output :

- Check the `output` folder. Input programs are from `tests` folder.

## References & Links : 

- New LLVM Pass Manager : 
	- https://llvm.org/docs/NewPassManager.html
	- https://llvm.org/docs/WritingAnLLVMNewPMPass.html

- For function paraments as operands, you can get it get it via Function Argumentslist()
	- Reference : https://llvm.org/doxygen/group__LLVMCCoreValueFunctionParameters.html
	- Value reference : http://llvm.org/doxygen/classllvm_1_1Value.html
	- User class : for getnumoperands, getoperands etc. https://llvm.org/doxygen/classllvm_1_1User.html

- Some other differences are listed here.
	- https://llvm.org/docs/ProgrammersManual.html#llvm-adt-densemap-h . Even C++ one is quadratic probed. 

- Where is "emit-llvm"? ASMWritter `AsmWritter.cpp`.
	- https://github.com/llvm-mirror/llvm/blob/master/tools/gold/gold-plugin.cpp#L232
	- https://www.cs.cornell.edu/~asampson/blog/llvm.html

LLVM Data Structures :
- https://llvm.org/docs/ProgrammersManual.html#picking-the-right-data-structure-for-a-task

LLVM RTTI
- https://llvm.org/docs/HowToSetUpLLVMStyleRTTI.html#id1

- Inspection & Traversal over `CFG` in `IR`. 
	- https://llvm.org/docs/ProgrammersManual.html#basic-inspection-and-traversal-routines
	- https://llvm.org/docs/ProgrammersManual.html#making-simple-changes
