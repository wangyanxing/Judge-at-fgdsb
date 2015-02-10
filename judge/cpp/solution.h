char smallest_character(string& str, char c) {
    for(auto ch : str) {
        if (ch > c) return ch;
    }
    return str[0];
}