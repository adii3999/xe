import React from 'react';

export default function Commission() {
  return (
    <section>
      <h3>Commission</h3>
      <p>Control commission rates (mock).</p>
      <label>
        Default commission: <input type="number" defaultValue={3} />%
      </label>
    </section>
  );
}
