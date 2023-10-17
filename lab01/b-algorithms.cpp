int isPalindrome(char *s) {
    int l = 0;                      // start iterator
    int h = strlen(s) - 1;          // end iterator

    while(l < h) {                  // work left to right from the start,
        if(s[l++] != s[h--]) {      // right to left from the end and compare characters
            return 0;               // if you find two characters that are not the same
        }                           // return 0, sice it's not palidrome
    }   
    return 1;                       // else, it's palidrome, so return 1
}

int strlen(char *s) {               
    char *p = s;                    // pointer p points to our string
    while(*p != '\0') {             // while p points to a char other than \0,
        p++;                        // p points to the next char
    }
    return p - s;                   // return strlen = end - start
}
