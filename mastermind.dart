import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:core';
 
 main() {
	print('                                     Lets Play!                              ');
      print('Rules :' + '\n' + '1.Enter the words on basis of the level selected.'+'\n' + "2.Don't choose any repeated letter words." + '\n'     + 'NOTE : Enter -1 when the computer guess matches your word');
     print('\n' + 'Choose your difficulty level :' + '\n' + '1.Easy' +'\n' +'2.Medium' + '\n' + '3.Difficult' + '\n' + '4.Quit');
     print('\n'+'Type your choice:');
     var difficulty = stdin.readLineSync().toLowerCase();
     switch(difficulty) {
         case 'easy':
             passing('wordlen4.txt');
             break;
         case 'medium' :
             passing('wordlen5.txt');
             break;
         case 'difficult' :
             passing('wordlen6.txt');
             break;
         case 'quit' :
             exit(0);
             break;
         default :
             exit(0);
             break;
     }
 }

 passing(file_name) async{
      var pick = await filetolist(file_name);
      Computer_mainWord(pick);
 }

 filetolist(from_file) {
     var contents = new File(from_file);
     return contents.readAsLines(); Utf8Encode;
 }

 random_pick(from_list) {
    var index = new Random();
     var list_len = from_list.length;
     var word = from_list[index.nextInt(list_len)];

     return frequency(word, from_list);
 }

 frequency(str, from_list) {
     var string_set = new Set();

     for(var i = 0; i < str.length; i++) {
         string_set.add(str[i]);
     }
     if(str.length == string_set.length) {
         return str;
    } else {
         return random_pick(from_list);
     }
 }

 Computer_mainWord(pick) {
     var computer_main = random_pick(pick);
   //  print(computer_main);
     Computer_guessWord(pick,computer_main.trim());
 }

 Computer_guessWord(pick,computer_main) {
     var computer_guess = random_pick(pick);
     print('My guess is ${computer_guess}');
     human_guess(computer_main, pick,computer_guess.trim());
 }

 human_guess(computer_main, pick,computer_guess) {
     print('Enter the number of common letters :');
     var user_count = int.parse(stdin.readLineSync());
     var count;

     if(user_count == -1) {
         print('I WON!');
         exit(0);
     }else {
         print('Enter your guess word :');
         var human_guess = stdin.readLineSync().trim();

         var computer_count = commonLetterCount(computer_main,human_guess);
        print('Your guess word is matched by ${computer_count} letters \n');
   
        if(computer_main == human_guess){
             print('You WON! \n');
             exit(0);
         } else if (computer_count == 0) {
             Computer_guessWord(pick,computer_main);
         } else {
             List amend_list = [];
             for(var i = 0; i < pick.length; i++) {
                 count = commonLetterCount(computer_guess, pick[i]);
                 if(count == user_count) {
                     amend_list.add(pick[i]);
                 }
             }
             Computer_guessWord(amend_list, computer_main);
         }
      }
 }

 commonLetterCount(word1, word2) {
     var count = 0;
     var len = word1.length;

      for(int i = 0; i < len; i++) {
         for(int j = 0; j < len; j++) {
             if(word1[i] == word2[j]) {
                 count++;
            }
         }
     }

     return count;
}
