import React, { Component } from 'react'

import { Card } from 'antd';

import "../../style/People/peopleCard.css";

const { Meta } = Card;
const gridStyle = {
    width: '25%',
    textAlign: 'center',
  };

export default class PeopleCard extends Component {

    render() {
        return (
        <div>
            <Card.Grid style={gridStyle}>
                <Card className="placeholder"
                    style={{ width: '100%' }}
                    cover={
                    <img alt="https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png"
                     src={this.props.image}
                      />}
                >
                if({this.props.role}==1){
                    // let className ='undergrad';
                }
                if({this.props.role}==2){
                    // let className ='master';
                }
                if({this.props.role}==3){
                    // style={background: rgb(148, 231, 148) }
                }
                
                    <Meta
                    title={this.props.title}
                    description={this.props.description}
                    />
                    <p>{this.props.email}</p>
                    <p>Plain string is working</p>
                    
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