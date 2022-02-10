class UtilFunctions {
  static bool listEquals(List a, List b) {
    int sizeA = a.length;
    int sizeB = b.length;
    if (sizeA != sizeB) return false;
    for (int i = 0; i < sizeA; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
