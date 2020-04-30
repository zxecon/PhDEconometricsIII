### PS3

#### Question on rdplot/rdrobust

Some of you encontered the following error:

```stata
c() should be set within the range of lagdemvoteshare
```
This is because you need to center the assignment variable so that the cut-off is zero for both programs to work, 
i.e. within your code, Stata does not know where is the cut-off.  

Since the default cut-off for both commands is 0, there are two ways to solve[set the center(cut-off) at 0.5]:

- You can generate a new variable (say test) by center the 'lagdemvoteshare'
```stata
gen test = lagdemvoteshare - 0.5
rdrobust democrat test, all
rdplot democrat test
```

- You can add function to the command by setting c = 0.5
```stata
rdrobust democrat x_c, c(0.5) all
rdplot democrat lagdemvoteshare, c(0.5)
```
