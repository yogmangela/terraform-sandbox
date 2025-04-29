import streamlit as st
import folium
from streamlit_folium import folium_static
from streamlit_javascript import st_javascript
import requests

st.set_page_config(page_title="Live London Map with Address Info", layout="wide")
st.title("📍 Live Location Map + Search (London)")

# Get live geolocation
coords = st_javascript("""await new Promise((resolve) => {
    navigator.geolocation.getCurrentPosition(
        (pos) => resolve([pos.coords.latitude, pos.coords.longitude]),
        (err) => resolve(null)
    );
})""")

# Defaults
lat, lon = 51.5074, -0.1278
location_source = "Central London"
address_info = {}

# Search bar for manual input
search_query = st.text_input("🔍 Search for a location (e.g., 'Tower Bridge, London')")

if search_query:
    st.info(f"📍 Searching for: {search_query}")
    geocode_url = f"https://nominatim.openstreetmap.org/search?q={search_query}&format=json&limit=1"
    try:
        resp = requests.get(geocode_url, headers={"User-Agent": "streamlit-london-map"})
        data = resp.json()
        if data:
            lat = float(data[0]['lat'])
            lon = float(data[0]['lon'])
            location_source = f"Search: {search_query}"
        else:
            st.warning("❌ Location not found.")
    except:
        st.error("Error contacting geocoding API.")
elif coords:
    lat, lon = coords
    location_source = "Your Location"

    # Reverse geocode
    try:
        url = f"https://nominatim.openstreetmap.org/reverse?format=json&lat={lat}&lon={lon}&zoom=18&addressdetails=1"
        headers = {"User-Agent": "streamlit-london-map"}
        response = requests.get(url, headers=headers)
        data = response.json()
        address = data.get("address", {})
        address_info = {
            "Street": address.get("road", "N/A"),
            "Borough": address.get("suburb", address.get("city_district", "N/A")),
            "Postcode": address.get("postcode", "N/A"),
            "City": address.get("city", address.get("town", "N/A")),
            "Latitude": f"{lat:.5f}",
            "Longitude": f"{lon:.5f}",
        }
    except Exception:
        st.warning("Could not retrieve detailed address info.")
else:
    st.info("Showing default Central London.")

# Show address table if available
if address_info:
    st.markdown("### 🧾 Address Details")
    st.table(address_info)

# Draw map
m = folium.Map(location=[lat, lon], zoom_start=15)
folium.Marker(
    [lat, lon],
    popup=location_source,
    tooltip="📍",
    icon=folium.Icon(color="blue")
).add_to(m)

folium_static(m, width=900, height=600)