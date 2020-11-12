import React, {useState } from 'react';
import styled from 'styled-components';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCaretDown } from "@fortawesome/free-solid-svg-icons"
import FilterListWrapper from './FilterListWrapper';

const Button = styled.button`
    width: 100px;
    background-color: #f3f3f3;
    border: none;
    cursor: pointer;
    font-size: 14px;
    outline: none;
    margin-right: 20px;
    cursor: pointer;  
`;

const FilterButton = ({ name, right, children }) => {
    const [visible, setVisible] = useState(false);
    
    const openFilter = () => {
        setVisible(true)
    };
    
    const closeFilter = () => {
        setVisible(false)
    };

    return (
        <>
            <Button onClick={openFilter}>{name} <FontAwesomeIcon icon={faCaretDown} /></Button>
            { visible ? <FilterListWrapper name={name} onClick={closeFilter} right={right}>{children}</FilterListWrapper> : null}
        </>
    );
};

export default FilterButton;