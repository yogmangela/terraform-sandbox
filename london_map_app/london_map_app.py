import streamlit as st
import folium
from streamlit_folium import folium_static
from streamlit_javascript import st_javascript

st.set_page_config(page_title="Live Location Map", layout="wide")
st.title("📍 Your Live Location on the London Map")

coords = st_javascript("""await new Promise((resolve) => {
    navigator.geolocation.getCurrentPosition(
        (pos) => resolve([pos.coords.latitude, pos.coords.longitude]),
        (err) => resolve(null)
    );
})""")

if coords:
    lat, lon = coords
    st.success(f"📡 Location detected: ({lat:.4f}, {lon:.4f})")
else:
    lat, lon = 51.5074, -0.1278
    st.warning("⚠️ Location not shared. Showing Central London.")

m = folium.Map(location=[lat, lon], zoom_start=13)

folium.Marker(
    [lat, lon],
    popup="You are here!",
    tooltip="Your Location",
    icon=folium.Icon(color="blue")
).add_to(m)

folium_static(m, width=900, height=600)