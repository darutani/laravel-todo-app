import React from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Sample from "./pages/Sample";
import Sample2 from "./pages/Sample2";


function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/sample" element={<Sample />} />
                <Route path="/sample2" element={<Sample2 />} />
            </Routes>
        </BrowserRouter>
    );
}

const container = document.getElementById('app');

if (container) {
    const root = createRoot(container);
    root.render(<App />);
} else {
    console.error("No elements can be rendered!");
}
