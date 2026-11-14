package se.stuk.rurik;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.WindowInsets;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import java.io.ByteArrayInputStream;
import java.io.IOException;

/** Offline Android host. Only packaged assets are served; no network permission or JS bridge. */
public final class MainActivity extends Activity {
    public WebView webView;
    @SuppressLint("SetJavaScriptEnabled")
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        getWindow().setStatusBarColor(Color.BLACK);
        getWindow().setNavigationBarColor(Color.BLACK);
        webView = new WebView(this);
        webView.setBackgroundColor(Color.BLACK);
        webView.setOverScrollMode(View.OVER_SCROLL_NEVER);
        webView.setVerticalScrollBarEnabled(false);
        webView.setHorizontalScrollBarEnabled(false);
        WebSettings settings = webView.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setTextZoom(100);
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        settings.setAllowFileAccess(false);
        settings.setAllowContentAccess(false);
        settings.setMediaPlaybackRequiresUserGesture(true);
        settings.setSupportZoom(false);
        WebView.setWebContentsDebuggingEnabled(BuildConfig.DEBUG);
        webView.setWebViewClient(new WebViewClient() {
            @Override public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return !"app.stuk.local".equals(request.getUrl().getHost());
            }
            @Override public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                Uri uri = request.getUrl();
                if (!"https".equals(uri.getScheme()) || !"app.stuk.local".equals(uri.getHost())) return missing();
                String path = uri.getPath();
                if (path == null || path.contains("..")) return missing();
                if (path.equals("/")) path = "/index.html";
                String mime = path.endsWith(".html") ? "text/html" : path.endsWith(".js") ? "application/javascript"
                    : path.endsWith(".css") ? "text/css" : path.endsWith(".json") ? "application/json"
                    : path.endsWith(".png") ? "image/png" : path.endsWith(".svg") ? "image/svg+xml" : "image/jpeg";
                try { return new WebResourceResponse(mime, "UTF-8", getAssets().open("www" + path)); }
                catch (IOException error) { return missing(); }
            }
        });
        FrameLayout container = new FrameLayout(this);
        container.setBackgroundColor(Color.BLACK);
        container.addView(webView, new FrameLayout.LayoutParams(-1, -1));
        setContentView(container);
        // API 35 draws edge to edge by default. Keep controls inside the real Android system bars.
        container.setOnApplyWindowInsetsListener((view, insets) -> {
            if (android.os.Build.VERSION.SDK_INT >= 30) {
                android.graphics.Insets bars = insets.getInsets(WindowInsets.Type.systemBars() | WindowInsets.Type.displayCutout());
                view.setPadding(bars.left, bars.top, bars.right, bars.bottom);
            }
            return insets;
        });
        container.requestApplyInsets();
        if (state == null || webView.restoreState(state) == null) webView.loadUrl("https://app.stuk.local/index.html");
    }
    private static WebResourceResponse missing() {
        return new WebResourceResponse("text/plain", "UTF-8", 404, "Not Found", java.util.Collections.emptyMap(), new ByteArrayInputStream(new byte[0]));
    }
    @Override public void onBackPressed() {
        webView.evaluateJavascript("window.appBack ? window.appBack() : false", value -> {
            if (!"true".equals(value)) finish();
        });
    }
    @Override protected void onSaveInstanceState(Bundle state) { super.onSaveInstanceState(state); webView.saveState(state); }
    @Override protected void onPause() { webView.onPause(); super.onPause(); }
    @Override protected void onResume() { super.onResume(); webView.onResume(); }
    @Override protected void onDestroy() { webView.destroy(); super.onDestroy(); }
}
