import React from 'react';
const ItemDetail = ({item}) => {
  return(
    <div>
      <ul>
        <li>{item.name}</li>
        <li>Happiness: {item.happiness}</li>
        <li>Price: {item.price}</li>
      </ul>
    </div>
  );
};

export default ItemDetail;
