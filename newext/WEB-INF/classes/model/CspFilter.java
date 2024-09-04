package model;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CspFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            // Set the CSP header based on your policy

            httpResponse.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self'; style-src 'self';img-src *;");
        }

        // Continue the filter chain
        chain.doFilter(request, response);
    }

    public void destroy() {
        // Cleanup code if needed
    }
}

