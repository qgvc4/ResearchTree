import React, { Component } from 'react'

import { Card, Avatar } from 'antd';

import { Standings } from '../../declaration/standing';

import "../../style/People/peopleCard.css";

const { Meta } = Card;
const gridStyle = {
    width: '25%',
    textAlign: 'center',
  };  

export default class PeopleCard extends Component {
    
    render() {
        const { people } = this.props;
        console.log(people)
        var style = Standings[people.standing];
        console.log(people)
        const peopleProfile = `data:image/jpeg;base64,${people.image}`
        const initial = `${people.firstname.charAt(0)}${people.lastname.charAt(0)}`
        const avatar = people.image ? 
            <Avatar alt="profile" src={peopleProfile} />
            : <Avatar>{initial}</Avatar>

        const fullname = `${people.firstname} ${people.lastname}`
        return (
        <div>
            <Card.Grid style={gridStyle}>
                <Card className="placeholder"
                    style={{ width: '100%' }}
                >

                    <div className={style}/>
                    <div className="avatar">{ avatar }</div>
                    <Meta
                    title={fullname}
                    description={people.description}
                    />
                    <p>{people.email}</p>
                    
                </Card>
            </Card.Grid>
            {/* <Card
                title={this.props.title}
                extra={this.props.date}
            >
                {this.props.description}
            </Card> */}
        </div>
        )
    }
}