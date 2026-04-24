class PrDetectionService {
  const PrDetectionService();

  bool isNewRepMax({
    required double currentEstimate,
    required double previousBestEstimate,
  }) {
    return currentEstimate > previousBestEstimate;
  }
}
