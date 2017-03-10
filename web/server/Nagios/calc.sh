#!/bin/bash
# SCRIPT:  main_calc.sh
# USAGE:   main_calc.sh
# PURPOSE: Addition, Subtraction, Division and Multiplication of
#          two numbers.
#
#####################################################################
#                      Variable Declaration                         #
#####################################################################

clear                        #Clears Screen

Bold="\033[1m"               #Storing escape sequences in a variable.
Normal="\033[0m"

echo -e "$Bold Basic mathematics using bash script $Normal\n"

items="1. ADDITTION
        2. SUBTRACTION
        3. MULTIPLICATION
        4. DIVISION
        5. EXIT"

choice=

#####################################################################
#                      Define Functions Here                        #
#####################################################################


exit_function()
{
   clear
   exit
}

#Function enter is used to go  back to menu and clears screen

enter()
{
   unset num1 num2
   ans=
   echo ""
   echo -e  "Do you want to continue(y/n):\c"
   stty -icanon min 0 time 0


while [ -z "$ans" ]
do
   read ans
done

#The while loop ensures that so long as at least one character is

if [ "$ans" = "y" -o "$ans" = "Y" ]
then
   stty sane          # Restoring terminal settings
   clear
else
   stty sane
   exit_function
fi
}

#####################################################################
#                         Main Scricpt                              #
#####################################################################

while true
do
   echo -e "$Bold \tWelcome to Panterra Networks $Normal\n"
   echo -e "\t$items \n"
   echo -n "Enter your choice : "
   read choice

   case $choice in
     1) clear
        echo  "Enter two numbers for Addition : "
        echo -n "Number1: "
        read num1
        echo -n "Number2: "
        read num2
        echo "$num1 + $num2 = `expr $num1 + $num2`"
         ;;
     2) clear
        echo "Enter two numbers for Subtraction : "
        echo -n "Number1: "
        read num1
        echo -n "Number2: "
        read num2
        echo "$num1 - $num2 = $((num1-num2))"
        enter ;;
     3) clear
        echo "Enter two numbers for Multiplication : "
        echo -n "Number1: "
        read num1
        echo -n "Number2: "
        read num2
        echo "$num1 * $num2 = `echo "$num1*$num2"|bc`"
        enter ;;
    4)  clear
        echo "Enter two numbers for Division : "
        echo -n "Number1: "
        read num1
        echo -n "Number2: "
        read num2
        let div=num1/num2
        echo "$num1 / $num2 = $div"
        enter ;;
    5)  exit_function  ;;
    *)  echo "You entered wrong option, Please enter 1,2,3,4 or 5"
        echo "Press enter to continue"
        read
        clear
   esac

done 
