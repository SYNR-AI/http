import 'cupertino_api.dart';
import 'native_cupertino_bindings.dart' as ncb;
import 'utils.dart';

typedef URLRequestFilterBlock = bool Function(URLRequest request);

abstract class CupertinoCronetCacheType {
  /// Disabled HTTP cache.  Some data may still be temporarily stored in memory.
  static const int CupertinoCronetHttpCacheTypeDisabled = 0;

  /// Enable on-disk HTTP cache, including HTTP data.
  static const int CupertinoCronetHttpCacheTypeDisk = 1;

  /// Enable in-memory cache, including HTTP data.
  static const int CupertinoCronetHttpCacheTypeMemory = 2;
}

class CupertinoCronet {

  static void setAcceptLanguages(String acceptLanguages) {
    ncb.Cronet.setAcceptLanguages_(
        linkedLibs, acceptLanguages.toNSString(linkedLibs));
  }

  static void setHttp2Enabled(bool http2Enabled) {
    ncb.Cronet.setHttp2Enabled_(linkedLibs, http2Enabled);
  }

  static void setQuicEnabled(bool quicEnabled) {
    ncb.Cronet.setQuicEnabled_(linkedLibs, quicEnabled);
  }

  static void setQuicHint(String host, int port, int alternatePort) {
    ncb.Cronet.addQuicHint_port_altPort_(
        linkedLibs, host.toNSString(linkedLibs), port, alternatePort);
  }

  static void setBrotliEnabled(bool brotliEnabled) {
    ncb.Cronet.setBrotliEnabled_(linkedLibs, brotliEnabled);
  }

  static void setMetricsEnabled(bool metricsEnabled) {
    ncb.Cronet.setMetricsEnabled_(linkedLibs, metricsEnabled);
  }

  static void setHttpCacheType(int cacheType) {
    ncb.Cronet.setHttpCacheType_(linkedLibs, cacheType);
  }

  static void setExperimentalOptions(String experimentalOptions) {
    ncb.Cronet.setExperimentalOptions_(
        linkedLibs, experimentalOptions.toNSString(linkedLibs));
  }

  static void setUserAgent_partial(String userAgent, bool partial) {
    ncb.Cronet.setUserAgent_partial_(
        linkedLibs, userAgent.toNSString(linkedLibs), partial);
  }

  static void setSslKeyLogFileName(String sslKeyLogFileName) {
    ncb.Cronet.setSslKeyLogFileName_(
        linkedLibs, sslKeyLogFileName.toNSString(linkedLibs));
  }

  static void setRequestFilterBlock(URLRequestFilterBlock block) {
    ncb.Cronet.setRequestFilterBlock_(
        linkedLibs,
        ncb.ObjCBlock_bool_NSURLRequest.fromFunction(
            linkedLibs,
            (ncb.NSURLRequest request) =>
                block(URLRequest.fromNativeURLRequest(request))));
  }

  static void setRequestFilterHostWhiteList(List<String> hostWhiteList) {
    var nativeHostWhiteList = ncb.NSMutableArray.alloc(linkedLibs).init();
    for (var host in hostWhiteList) {
      nativeHostWhiteList.addObject_(host.toNSString(linkedLibs));
    }
    ncb.CUPCronetProxy.setInterceptHostWhiteList_(linkedLibs, nativeHostWhiteList);
  }

  static void start() {
    ncb.Cronet.start(linkedLibs);
  }

  static void registerHttpProtocolHandler() {
    ncb.Cronet.registerHttpProtocolHandler(linkedLibs);
  }

  static void unregisterHttpProtocolHandler() {
    ncb.Cronet.unregisterHttpProtocolHandler(linkedLibs);
  }

  static void installIntoSessionConfiguration(
      URLSessionConfiguration config) {
    ncb.Cronet.installIntoSessionConfiguration_(linkedLibs, config.nsObject);
  }

  static String getNetLogPathForFile(String fileName) {
    ncb.NSString path = ncb.Cronet.getNetLogPathForFile_(
        linkedLibs, fileName.toNSString(linkedLibs));
    return path.toString();
  }

  static bool startNetLogToFile(String fileName, bool logBytes) {
    return ncb.Cronet.startNetLogToFile_logBytes_(
        linkedLibs, fileName.toNSString(linkedLibs), logBytes);
  }

  static void stopNetLog() {
    return ncb.Cronet.stopNetLog(linkedLibs);
  }

  static String getUserAgent() {
    ncb.NSString userAgent = ncb.Cronet.getUserAgent(linkedLibs);
    return userAgent.toString();
  }

  static void setNetworkThreadPriority(double priority) {
    ncb.Cronet.setNetworkThreadPriority_(linkedLibs, priority);
  }

  static void setHostResolverRulesForTesting(
      String hostResolverRulesForTesting) {
    ncb.Cronet.setHostResolverRulesForTesting_(
        linkedLibs, hostResolverRulesForTesting.toNSString(linkedLibs));
  }

  static void enableTestCertVerifierForTesting() {
    ncb.Cronet.enableTestCertVerifierForTesting(linkedLibs);
  }
}
