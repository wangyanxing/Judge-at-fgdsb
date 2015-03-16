bool happy(int number) {
  map<int, bool> cache;
  set<int> cycle;
  
  while (number != 1 && !cycle.count(number)) {
    if (cache.count(number)) {
      number = cache[number] ? 1 : 0;
      break;
    }
    cycle.insert(number);
    int newnumber = 0;
    while (number > 0) {
      int digit = number % 10;
      newnumber += digit * digit;
      number /= 10;
    }
    number = newnumber;
  }
  bool happiness = number == 1;
  for (auto it = cycle.begin(); it != cycle.end(); it++)
    cache[*it] = happiness;
  return happiness;
}